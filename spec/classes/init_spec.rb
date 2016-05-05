require 'spec_helper'
describe 'ca_certificates' do

  context 'with defaults for all parameters' do
    it { should contain_class('ca_certificates') }
  end
end
