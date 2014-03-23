# encoding: utf-8
require 'spec_helper'

describe ApplicationHelper do
  describe 'markdown' do
    context 'with text' do
      it 'should convert text to markdown' do
        expect(markdown('# test')).to eq("<h1>test</h1>\n")
      end
    end
  end
end
