require 'linkbucks'
require_relative 'spec_helper'

describe Linkbucks::API do
  
  let!(:linkbucks) { Linkbucks::API.new VALID_USER, VALID_PASS }

  describe "#initialize" do
    it "take two params" do
      expect { Linkbucks::API.new('') }.to raise_error(ArgumentError)
      expect { Linkbucks::API.new('', '') }.not_to raise_error
    end
  end

  describe "#create_link_single" do
    context 'with valid params' do
      it "return hash" do
        expect(linkbucks.create_link_single(originalLink: 'http://www.google.es')).to be_kind_of(Hash)
      end

      it "response has linkId and link" do
        expect(linkbucks.create_link_single(originalLink: 'http://www.google.es')).to include('linkId' => VALID_LINK_ID, 'link' => VALID_LINK)
      end
    end

    context 'with invalid params' do

      it "return ArgumentError if adType is invalid" do
        expect { linkbucks.create_link_single(originalLink: 'http://www.google.es', adType: 'invalid') }.to raise_error(ArgumentError)
      end

      it "return ValidationFailed if adType is invalid" do
        expect { linkbucks.create_link_single(originalLink: 'google.es') }.to raise_error(Linkbucks::ValidationFailed)
      end

      it "return OperationFailed if adType is invalid" do
        expect { linkbucks.create_link_single(originalLink: 'http://www.google.es', contentType:'operationFailed') }.to raise_error(Linkbucks::OperationFailed)
      end

      it "return AuthenticationFailed if user or pass are invalid" do
        linkbucks = Linkbucks::API.new VALID_USER, INVALID_PASS
        expect { linkbucks.create_link_single(originalLink: 'http://www.google.es') }.to raise_error(Linkbucks::AuthenticationFailed)
      end
    end

  end

end
