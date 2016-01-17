require 'rails_helper'

describe MowerController, type: :controller do
  let!(:lawn) { Lawn.create(width: 3, height: 3) }
  let(:x) { '0' }
  let(:y) { '0' }
  let(:heading) { 'N' }
  let(:commands) { 'MMRM' }
  let(:params) do
    {
      lawn_id: lawn.id,
      x: x, y: y,
      heading: heading,
      commands: commands
    }
  end

  describe '#create' do
    it 'should create a new mower' do
      expect do
        post :create, params
      end.to change { Mower.count }.by(1)
      expect(Mower.last.heading).to eq 'N'
    end
  end

  describe '#show' do
    let!(:mower) { Mower.create params }

    it 'should return a lawn object' do
      get :show, id: mower.id, lawn_id: mower.lawn_id
      expect(response.body).to eq(mower.to_json)
    end

    context 'when id is invalid' do
      it 'should return nothing' do
        get :show, id: 3, lawn_id: lawn.id
        expect(response.body).to eq('[]')
      end
    end
  end

  describe '#update'  do
    let!(:mower) { Mower.create params }

    it 'should return a lawn object' do
      put :update, id: mower.id, lawn_id: lawn.id, x: 1, y: 2
      mower.reload
      expect(mower.x).to eq(1)
      expect(mower.y).to eq(2)
      expect(response.body).to eq(mower.to_json)
    end

    context 'when id is invalid' do
      it 'should return nothing' do
        put :update, id: 3, lawn_id: lawn.id
        expect(response.body).to eq('[]')
      end
    end
  end

  describe '#destroy'  do
    let!(:mower) { Mower.create params }

    it 'should return a lawn object' do
      expect do
        delete :destroy, lawn_id: lawn.id, id: mower.id
      end.to change { Mower.count }.by(-1)
      expect(json_response).to eq({'status' => 'ok'})
    end

    context 'when id is invalid' do
      it 'should return nothing' do
        delete :destroy, id: 3, lawn_id: lawn.id
        expect(response.body).to eq('[]')
      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
