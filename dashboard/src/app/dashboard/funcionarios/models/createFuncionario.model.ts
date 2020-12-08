import { Role } from './../../../models/Login.model';
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
    id?: number
    name: string,
    email: string,
    password: string,
    roles?:any
  };
  contactos: Array<Role>;
  morada: any;
  roles: any;
}
