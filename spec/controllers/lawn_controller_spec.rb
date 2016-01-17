require 'rails_helper'

describe LawnController, type: :controller do
  describe '#create' do
    it 'should create a new lawn' do
      expect do
        post :create, { width: '5', height: '5' }
      end.to change { Lawn.count }.by(1)
      expect(Lawn.last.width).to eq 5
      expect(Lawn.last.height).to eq 5
    end

    context 'when input is invalid' do
      it 'should return errors' do
        post :create, { width: 'fish', height: '5' }
        errors  = json_response['errors']
        expect(errors.count).to eq(1)
      end
    end
  end

  describe '#show' do
    let!(:lawn) { Lawn.create(width: 3, height: 3) }
    it 'should return a lawn object' do
      get :show, id: lawn.id
      expect(response.body).to eq(lawn.to_json)
    end

    context 'when id is invalid' do
      it 'should return nothing' do
        get :show, id: 3
        expect(response.body).to eq('[]')
      end
    end
  end

  describe '#update'  do
    let!(:lawn) { Lawn.create(width: 3, height: 3) }
    it 'should return a lawn object' do
      put :update, id: lawn.id, width: 4, height: 4
      lawn.reload
      expect(lawn.width).to eq(4)
      expect(lawn.height).to eq(4)
      expect(response.body).to eq(lawn.to_json)
    end

    context 'when id is invalid' do
      it 'should return nothing' do
        put :update, id: 3
        expect(response.body).to eq('[]')
      end
    end
  end

  describe '#destroy'  do
    let!(:lawn) { Lawn.create(width: 3, height: 3) }
    it 'should return a lawn object' do
      expect do
        delete :destroy, id: lawn.id
      end.to change { Lawn.count }.by(-1)
      expect(json_response).to eq({'status' => 'ok'})
    end

    context 'when id is invalid' do
      it 'should return nothing' do
        delete :destroy, id: 3
        expect(response.body).to eq('[]')
      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
