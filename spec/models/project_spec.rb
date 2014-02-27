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

  describe '.search' do
    describe 'when matching a title' do
      it 'should return a search result' do
        FactoryGirl.create(:project)
        result = Project.search('Some')
        expect(result.count).to eq(1)
      end
    end

    describe 'when not matching any title' do
      it 'should return a search result' do
        FactoryGirl.create(:project)
        result = Project.search('asdf')
        expect(result.count).to eq(0)
      end
    end
  end
end
