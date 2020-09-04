
    export interface Usuario {
        name: string;
        email: string;
        password: string;
        roles: number[];
    }

    export interface UserRegister {
        nome: string;
        genero: string;
        usuario: Usuario;
        contactos: any;
    }

