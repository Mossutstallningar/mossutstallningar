# encoding: utf-8
require 'spec_helper'

describe Page do
  describe 'validations' do
    it 'should have be valid' do
      expect(FactoryGirl.build(:page)).to be_valid
    end

    it 'should have require a title' do
      expect(FactoryGirl.build(:page, title: '')).not_to be_valid
    end
  end

  describe '.search' do
    describe 'when matching a title' do
      it 'should return a search result' do
        FactoryGirl.create(:page)
        result = Page.search('Some')
        expect(result.count).to eq(1)
      end
    end

    describe 'when not matching any title' do
      it 'should return a search result' do
        FactoryGirl.create(:page)
        result = Page.search('asdf')
        expect(result.count).to eq(0)
      end
    end
  end
end
