export class Relatorio {
    total_vans: number;
    vans_modelo: {
        nome: string,
        qtd: number
    };
    funcionario_viagens: {
        nome: string,
        qtd
    }
}

export interface Viagens  {
  name: string;
  viagem: number;
}

export interface Motoristas {
  name: string;
  viagens: number;
  viagensAnalisadas: number;
  avalicaoM: number;
}


export interface Data {
  motoristas: Motoristas[];
  viagens: Viagens[];
}
export interface ResponseRelatorios {
  data: Data;
  status: boolean;
  numRows: number;
}


export interface serchParams {
  dataIni: string;
  dataFin: string;
}
