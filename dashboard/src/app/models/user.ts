    export interface Contacto {
        id: number;
        contacto: string;
        tipo: string;
        funcionario_id: number;
        created_at: string;
        updated_at: string;
    }

    export interface Funcionario {
        id: number;
        nome: string;
        nacionalidade: string;
        genero: string;
        data_nascimento?: any;
        nr_bi?: any;
        nif?: any;
        imagem: string;
        usuario_id: number;
        created_at: string;
        updated_at: string;
        contactos: Contacto[];
        morada?: any;
    }

    export interface Role {
        id: number;
        name: string;
        display_name: string;
        description?: any;
    }

    export interface DataUser {
        id: number;
        name: string;
        email: string;
        email_verified_at?: any;
        created_at: string;
        updated_at: string;
        funcionario: Funcionario;
        roles: Role[];
    }


