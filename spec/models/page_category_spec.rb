# encoding: utf-8
require 'spec_helper'

describe Page do
  describe 'validations' do
    it 'should have be valid' do
      expect(FactoryGirl.build(:page_category)).to be_valid
    end

    it 'should have require a name' do
      expect(FactoryGirl.build(:page_category, name: '')).not_to be_valid
    end
  end
end
