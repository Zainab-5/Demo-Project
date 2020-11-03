require 'rails_helper'
require "auth_helper"
include AuthHelper

RSpec.describe PlansController, type: :controller do

  before(:all) do
    @plan = create(:plan)
  end

  context 'GET #index' do
    context 'With user login' do
      before(:each) do
        login_user('Buyer')
      end
      it 'returns a success response' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context 'Without user login' do
      it 'redirects to sign in page' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context 'post #create' do
    context 'Without user login' do
      it 'redirects to sign in page' do
        plan_hash = {name: 'plan1', fee: 200, user_id: 42}
        post :create, params: {plan: plan_hash}
        expect(response).to redirect_to new_user_session_path
      end
    end
    context "with authorized user" do
      before(:each) do
        login_user('Admin')
      end
      context "with valid params" do
        it "redirects to the created plan" do
          plan_hash = {name: 'plan1', fee: 200, user_id: 42}
          post :create, params: {plan: plan_hash}
          expect(response).to redirect_to plans_path
          expect(flash[:alert]).to match(/^Successfully created a plan/)
        end
      end
      context "with in-valid params" do
        it "redirects to the created plan" do
          plan_hash = { fee: 200, user_id: 42}
          post :create, params: {plan: plan_hash}
          expect(response).to redirect_to plans_path
          expect(flash[:notice]).to match(/^Cannot create a plan/)
        end
      end
    end

    context "with un-authorized user" do
      before(:each) do
        login_user('Buyer')
      end
      it "redirects to the plans index page" do
        plan_hash = {name: 'plan1', fee: 200, user_id: 42}
        post :create, params: {plan: plan_hash}
        expect(response).to redirect_to plans_path
        expect(flash[:alert]).to match(/^You are not authorized to do this action./)
      end
    end
  end


  context 'delete #destroy' do
    context 'Without user login' do
      it 'redirects to sign in page' do
        delete :destroy, params: {id: 1}
        expect(response).to redirect_to new_user_session_path
      end
    end
    context "with authorized user" do
      before(:each) do
        login_user('Admin')
      end
      context "can't delete a subscribed plan" do
        it "redirects to the plans idex page" do
          delete :destroy, params: {id: 1}
          expect(response).to redirect_to plans_path
        end
      end
      context "successfully deleted a subscribed plan" do
        it "doesn't reload page" do
          plan = create(:plan)
          delete :destroy, xhr: true, params: {id: plan.id}
          expect(response).not_to be_redirect
        end
      end
    end

    context "with un-authorized user" do
      before(:each) do
        login_user('Buyer')
      end
      it "redirects to the plans idex page" do
        expect(response).not_to be_redirect
      end
    end
  end

  describe "PATCH #update" do
    context 'Without user login' do
      it 'redirects to sign in page' do
        patch :update, params: { id: @plan.id, plan: { name: "xyz", fee: 5000} }
        expect(response).to redirect_to new_user_session_path
      end
    end
    context "with authorized user" do
      before(:each) do
        login_user('Admin')
      end
      context "with correct params" do
        it "updates the plan and redirects" do
          patch :update, params: { id: @plan.id, plan: { name: "xyz", fee: 5000} }
          expect(response).to  redirect_to plans_path
          expect(flash[:alert]).to match(/^Successfully updated a plan/)
        end
      end
      context "with incomplete data" do
        it "does not change the plan, and re-renders the form" do
          patch :update, params: { id: @plan.id, plan: { name: "", fee: 5000} }
          expect(response).not_to be_redirect
        end
      end
    end

    context "with un-authorized user" do
      before(:each) do
        login_user('Buyer')
      end
      it "shows alert that you are not authorized to do this" do
        patch :update, params: { id: @plan.id, plan: { name: "", fee: 5000} }
        expect(response).to redirect_to plans_path
        expect(flash[:alert]).to match(/^You are not authorized to do this action./)
      end
    end
  end

  context 'get #new' do

    context "with authorized user" do
      before(:each) do
        login_user('Admin')
      end
      it "plan should be new" do
        plan = build(:plan)
        Plan.stub(:new).and_return(plan)
        get :new
        assigns(:plan).should == plan
      end
    end

    context "with un-authorized user" do
      before(:each) do
        login_user('Buyer')
      end
      it "plans path redirection" do
        expect(response).not_to be_redirect
      end
    end
  end

  describe "get #edit" do
    context "with authorized user" do
      before(:each) do
        login_user('Admin')
      end
      context "with correct params" do
        it "shoews edit page" do
          get :edit, params: { id: @plan.id, plan: { name: "xyz", fee: 5000} }
          response.success?
        end
      end
    end
    context "with un-authorized user" do
      before(:each) do
        login_user('Buyer')
      end
      it "redirects to plans index page" do
        expect(response).not_to be_redirect
      end
    end
  end

end
