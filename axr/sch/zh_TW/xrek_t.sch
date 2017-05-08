/* 
================================================================================
檔案代號:xrek_t
檔案名稱:壞帳提列明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xrek_t
(
xrekent       number(5)      ,/* 企業代碼 */
xrekcomp       varchar2(10)      ,/* 法人 */
xrekld       varchar2(5)      ,/* 帳別 */
xrekdocno       varchar2(20)      ,/* 單據號碼 */
xrekseq       number(10,0)      ,/* 序號 */
xrek001       number(5,0)      ,/* 年度 */
xrek002       number(5,0)      ,/* 期別 */
xrek003       varchar2(10)      ,/* 來源模組 */
xrek004       varchar2(10)      ,/* 帳款單性質 */
xrek005       varchar2(20)      ,/* 帳款單號碼 */
xrek006       number(10,0)      ,/* 帳款單項次 */
xrek007       number(5,0)      ,/* 分期帳款序 */
xrek008       date      ,/* 立帳日期 */
xrek009       varchar2(10)      ,/* 帳款對象 */
xrek010       varchar2(10)      ,/* 收款對象 */
xrek011       varchar2(10)      ,/* 部門 */
xrek012       varchar2(10)      ,/* 責任中心 */
xrek013       varchar2(10)      ,/* 區域 */
xrek014       varchar2(10)      ,/* 客群 */
xrek015       varchar2(10)      ,/* 產品類別 */
xrek016       varchar2(20)      ,/* 人員 */
xrek017       varchar2(20)      ,/* 專案代號 */
xrek018       varchar2(30)      ,/* WBS編號 */
xrek019       varchar2(24)      ,/* 壞帳科目 */
xrekorga       varchar2(10)      ,/* 來源組織 */
xrek020       varchar2(10)      ,/* 經營方式 */
xrek021       varchar2(10)      ,/* 渠道 */
xrek022       varchar2(10)      ,/* 品牌 */
xrek023       varchar2(30)      ,/* 自由核算項一 */
xrek024       varchar2(30)      ,/* 自由核算項二 */
xrek025       varchar2(30)      ,/* 自由核算項三 */
xrek026       varchar2(30)      ,/* 自由核算項四 */
xrek027       varchar2(30)      ,/* 自由核算項五 */
xrek028       varchar2(30)      ,/* 自由核算項六 */
xrek029       varchar2(30)      ,/* 自由核算項七 */
xrek030       varchar2(30)      ,/* 自由核算項八 */
xrek031       varchar2(30)      ,/* 自由核算項九 */
xrek032       varchar2(30)      ,/* 自由核算項十 */
xrek033       varchar2(255)      ,/* 摘要 */
xrek034       varchar2(10)      ,/* 信評等級 */
xrek035       varchar2(10)      ,/* 帳齡類型 */
xrek036       date      ,/* 帳齡起算日 */
xrek037       number(5,0)      ,/* 本期帳齡天數 */
xrek038       number(5,0)      ,/* 前期帳齡天數 */
xrek039       number(20,6)      ,/* 本期壞帳提列率 */
xrek040       number(20,6)      ,/* 前期壞帳提列率 */
xrek041       varchar2(24)      ,/* 備抵科目 */
xrek100       varchar2(10)      ,/* 幣別 */
xrek101       number(20,10)      ,/* 匯率 */
xrek103       number(20,6)      ,/* 本期原幣未沖金額 */
xrek104       number(20,6)      ,/* 前期原幣未沖金額 */
xrek105       number(20,6)      ,/* 本期原幣應計提壞帳金額 */
xrek106       number(20,6)      ,/* 前期原幣應計提壞帳金額 */
xrek107       number(20,6)      ,/* 本期實提原幣金額 */
xrek113       number(20,6)      ,/* 本期本幣未沖金額 */
xrek114       number(20,6)      ,/* 前期本幣未沖金額 */
xrek115       number(20,6)      ,/* 本期本幣應計提壞帳金額 */
xrek116       number(20,6)      ,/* 前期本幣應計提壞帳金額 */
xrek117       number(20,6)      ,/* 本期實提本幣金額 */
xrek121       number(20,10)      ,/* 本位幣二匯率 */
xrek123       number(20,6)      ,/* 本期本位幣二未沖金額 */
xrek124       number(20,6)      ,/* 前期本位幣二未沖金額 */
xrek125       number(20,6)      ,/* 本期本位幣二應計提壞帳金額 */
xrek126       number(20,6)      ,/* 前期本位幣二應計提壞帳金額 */
xrek127       number(20,6)      ,/* 本期實提本位幣二壞帳金額 */
xrek131       number(20,10)      ,/* 本位幣三匯率 */
xrek133       number(20,6)      ,/* 本期本位幣三未沖金額 */
xrek134       number(20,6)      ,/* 前期本位幣三未沖金額 */
xrek135       number(20,6)      ,/* 本期本位幣三應計提壞帳金額 */
xrek136       number(20,6)      ,/* 前期本位幣三應計提壞帳金額 */
xrek137       number(20,6)      ,/* 本期實提本位幣三壞帳金額 */
xrekud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrekud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrekud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrekud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrekud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrekud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrekud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrekud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrekud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrekud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrekud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrekud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrekud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrekud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrekud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrekud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrekud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrekud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrekud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrekud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrekud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrekud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrekud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrekud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrekud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrekud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrekud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrekud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrekud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrekud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrek_t add constraint xrek_pk primary key (xrekent,xrekdocno,xrekseq) enable validate;

create unique index xrek_pk on xrek_t (xrekent,xrekdocno,xrekseq);

grant select on xrek_t to tiptop;
grant update on xrek_t to tiptop;
grant delete on xrek_t to tiptop;
grant insert on xrek_t to tiptop;

exit;
