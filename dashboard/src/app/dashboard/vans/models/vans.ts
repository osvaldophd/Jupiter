

export interface Contacto {
    id: number;
    contacto: string;
    van_id: number;
    created_at: string;
    updated_at: string;
}

export interface Marca {
    id: number;
    nome: string;
    created_at: string;
    updated_at: string;
}

export interface Modelo {
    id: number;
    nome: string;
    marca_id: number;
    created_at: string;
    updated_at: string;
    marca: Marca;
}

export interface Van {
    id: number;
    matricula: string;
    descricao: string;
    modelo_id: number;
    ano_aquisicao?: any;
    nr_ocupantes: number;
    cor_id: number;
    imagem: string;
    created_at: string;
    updated_at: string;
    contactos: Contacto[];
    modelo: Modelo;
}

export interface Data {
    vans: Van[];
}

export interface ResponseVans {
    status: boolean;
    data: Data;
}

export interface ResponseVanDetail {
    status: boolean;
    van: Van[];
}



