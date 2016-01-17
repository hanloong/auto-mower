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

  describe '#execute' do
    let!(:lawn) { Lawn.create(width: 5, height: 5) }
    let(:command1) { 'LMLMLMLMM' }
    let(:command2) { 'MMRMMRMRRM' }
    let(:x1) { 1 }
    let(:y1) { 2 }
    let(:heading1) { 'N' }
    let(:x2) { 3 }
    let(:y2) { 3 }
    let(:heading2) { 'E' }
    let!(:mower1) do
      Mower.create(lawn: lawn,
                   x: x1,
                   y: y1,
                   heading: heading1,
                   commands: command1)
    end
    let!(:mower2) do
      Mower.create(lawn: lawn,
                   x: x2,
                   y: y2,
                   heading: heading2,
                   commands: command2)
    end

    it 'should mow the lawns returning the result' do
      post :execute, id: lawn.id
      expect(json_response).to eq({
        'id' => lawn.id,
        'width' => lawn.width,
        'height' => lawn.height,
        'mowers' => [
          {
            'id' => mower1.id,
            'x' => 1,
            'y' => 3,
            'heading' => 'N',
            'commands' => ''
          },
          {
            'id' => mower2.id,
            'x' => 5,
            'y' => 1,
            'heading' => 'E',
            'commands' => ''
          },
        ]
      })
    end

    context 'when theres a collision' do
      let(:x1) { 0 }
      let(:y1) { 0 }
      let(:heading1) { 'E' }
      let(:command1) { 'MMMLMM' }
      let(:x2) { 3 }
      let(:y2) { 0 }
      let(:heading2) { 'N' }
      let(:command2) { 'LMMMRM' }

      it 'should return an error' do
        post :execute, id: lawn.id
        errors = json_response['errors']
        expect(errors.first).to eq(['base', ['Oops, looks like two mowers ran into each other']])
      end
    end

    context 'when mower goes off the rails' do
      let(:x1) { 0 }
      let(:y1) { 0 }
      let(:heading1) { 'E' }
      let(:command1) { 'MMMLMM' }
      let(:x2) { 3 }
      let(:y2) { 0 }
      let(:heading2) { 'N' }
      let(:command2) { 'RMMMRM' }

      it 'should return an error' do
        post :execute, id: lawn.id
        errors = json_response['errors']
        expect(errors.first).to eq(['base', ['Oops, looks like a mower ran off the lawn']])

      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
