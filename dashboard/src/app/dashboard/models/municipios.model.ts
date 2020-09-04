export interface Municipio {
    id: number;
    nome: string;
    provincia_id: number;
}

export interface RootObject {
    status: boolean;
    municipios: Municipio[];
}

