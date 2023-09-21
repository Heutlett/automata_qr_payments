// hosts
const facturasApi = 'app-development-lanx4oofmq-uc.a.run.app';
const authApi = 'auth-development-lanx4oofmq-uc.a.run.app';

// authenticacion
const postLoginUrl = 'https://$authApi/api/auth/login';
const postRegisterUrl = 'https://$authApi/api/auth/register';

// account management
const accountManagementUrl = 'https://$facturasApi/api/Cuenta';
const getAccountQrUrl =
    'https://$facturasApi/api/Cuenta/billing/cuenta_receptor';
const postAddSharedAccountByQrUrl = "https://$facturasApi/api/Cuenta/share";
const getAccountsUrl = 'https://$facturasApi/api/Cuenta/GetAll';

// facturas management
const postComprobanteUrl =
    'https://$facturasApi/api/Comprobante/comprobantes/add';
const getComprobantesSummaryUrl =
    'https://$facturasApi/api/Comprobante/comprobantes/summary';
const getComprobanteDetailsUrl =
    'https://$facturasApi/api/Comprobante/comprobantes';
