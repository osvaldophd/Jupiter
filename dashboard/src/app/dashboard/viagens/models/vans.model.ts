import { Contacto } from 'src/app/models/contacto.model';


export class Van {
    id?: number;
    matricula: string;
    descricao: string;
    modelo: string;
    marca: string;
    created_at: string;
    updated_at: string;
    contactos: Contacto;
}
