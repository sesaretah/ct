require 'test_helper'

class PrivacypoliciesControllerTest < ActionController::TestCase
  setup do
    @privacypolicy = privacypolicies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:privacypolicies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create privacypolicy" do
    assert_difference('Privacypolicy.count') do
      post :create, privacypolicy: { education_all: @privacypolicy.education_all, followers_all: @privacypolicy.followers_all, followess_all: @privacypolicy.followess_all, honor_all: @privacypolicy.honor_all, profile_birthdate: @privacypolicy.profile_birthdate, profile_fathername: @privacypolicy.profile_fathername, profile_mobilenumber: @privacypolicy.profile_mobilenumber, profile_phonenumber: @privacypolicy.profile_phonenumber, profile_sex: @privacypolicy.profile_sex, profile_ssn: @privacypolicy.profile_ssn, research_all: @privacypolicy.research_all, tag_all: @privacypolicy.tag_all }
    end

    assert_redirected_to privacypolicy_path(assigns(:privacypolicy))
  end

  test "should show privacypolicy" do
    get :show, id: @privacypolicy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @privacypolicy
    assert_response :success
  end

  test "should update privacypolicy" do
    patch :update, id: @privacypolicy, privacypolicy: { education_all: @privacypolicy.education_all, followers_all: @privacypolicy.followers_all, followess_all: @privacypolicy.followess_all, honor_all: @privacypolicy.honor_all, profile_birthdate: @privacypolicy.profile_birthdate, profile_fathername: @privacypolicy.profile_fathername, profile_mobilenumber: @privacypolicy.profile_mobilenumber, profile_phonenumber: @privacypolicy.profile_phonenumber, profile_sex: @privacypolicy.profile_sex, profile_ssn: @privacypolicy.profile_ssn, research_all: @privacypolicy.research_all, tag_all: @privacypolicy.tag_all }
    assert_redirected_to privacypolicy_path(assigns(:privacypolicy))
  end

  test "should destroy privacypolicy" do
    assert_difference('Privacypolicy.count', -1) do
      delete :destroy, id: @privacypolicy
    end

    assert_redirected_to privacypolicies_path
  end
end
