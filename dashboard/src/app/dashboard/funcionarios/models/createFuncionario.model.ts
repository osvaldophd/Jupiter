import {
  createMorada
} from './createMorada.model';
import {
  createUsuario
} from './createUsuario.model';

export class createFuncionario {
  nome: string;
  nacionalidade: string;
  genero: string;
  data_nascimento: string;
  nr_bi: string;
  nif: string;
  imagem: any;
  usuario: {
    name: string,
    email: string,
    password: string
  };
  contactos: any;
  morada: any;
  roles: any;
}
