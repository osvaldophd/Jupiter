

    export interface Role {
        id: number;
        name: string;
        display_name: string;
        description: string;
    }

    export interface Usuario {
        id: number;
        name: string;
        email: string;
        email_verified_at?: any;
        created_at: string;
        updated_at: string;
        roles: Role[];
    }

    export interface Contacto {
        id: number;
        contacto: string;
        tipo: string;
        funcionario_id: number;
    }

    export interface Provincia {
        id: number;
        nome: string;
    }

    export interface Municipio {
        id: number;
        nome: string;
        provincia_id: number;
        provincia: Provincia;
    }

    export interface Morada {
        id: number;
        rua: string;
        bairro: string;
        numero_casa: string;
        municipio_id: number;
        funcionario_id: number;
        municipio: Municipio;
    }

    export interface Funcionario {
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
        usuario: Usuario;
        contactos: Contacto[];
        morada: Morada;
    }

    export interface Data {
        funcionario: Funcionario[];
    }

    export interface ResponseFuncionario {
        status: boolean;
        data: Data;
    }


