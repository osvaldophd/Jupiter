export class Profile {

  id: number;
  name: string;
  email: string;
  email_verified_at: any;
  created_at: string;
  updated_at: string;
  funcionario: {
    id: number;
    nome: string;
    nacionalidade: string;
    genero: string;
    data_nascimento: string;
    nr_bi: string;
    nif: string;
    imagem: string;
    usuario_id: number;
    created_at: string;
    updated_at: string;
    contactos: any[];
  };
  roles: {
    id: number;
    name: string;
    display_name: string;
    description: string;
  };

}
