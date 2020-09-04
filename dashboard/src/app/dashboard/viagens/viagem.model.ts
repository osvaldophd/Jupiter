export class Viagem {
  status: boolean;


  id: number;
  usuario_id: number;
  motorista_id: number;
  van_id: number;
  hora_chamada: string;
  hora_chegada: string;
  hora_termino: string;
  avaliacao: number;
  comentario: string;
  viagem_terminada: number;
  created_at: string;
  updated_at: string;
  endereco_inicial: {
    id: number;
    viagem_id: number;
    tipo: string;
    latitude: number;
    longitude: number;
    descricao: string;
  };
  endereco_final: {
    id: number;
    viagem_id: number;
    tipo: string;
    latitude: number;
    longitude: number;
    descricao: string;
  };

  motorista: {
    nome: string,
    nacionalidade: string,
    genero: string,
    data_nascimento: string,
    nr_bi: string
    nif: string,
    imagem: string
  };


}
