# encoding: utf-8
require 'spec_helper'

describe Project do
  describe 'validations' do
    it 'should have be valid' do
      expect(FactoryGirl.build(:project)).to be_valid
    end

    it 'should have require a title' do
      expect(FactoryGirl.build(:project, title: '')).not_to be_valid
    end
  end
end
