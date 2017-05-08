/* 
================================================================================
檔案代號:fmnf_t
檔案名稱:平倉出售帳務單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmnf_t
(
fmnfent       number(5)      ,/* 企業代碼 */
fmnfdocno       varchar2(20)      ,/* 單號 */
fmnfseq       number(10,0)      ,/* 項次 */
fmnf001       varchar2(10)      ,/* 投資組織 */
fmnf002       varchar2(20)      ,/* 平倉單號 */
fmnf003       varchar2(1)      ,/* 來源 */
fmnf004       varchar2(10)      ,/* 收支方式 */
fmnf005       varchar2(10)      ,/* 收息銀行 */
fmnf006       varchar2(10)      ,/* 帳款對象 */
fmnf007       varchar2(10)      ,/* 收款對象 */
fmnf008       varchar2(10)      ,/* 部門 */
fmnf009       varchar2(10)      ,/* 利潤中心 */
fmnf010       varchar2(10)      ,/* 區域 */
fmnf011       varchar2(10)      ,/* 客群 */
fmnf012       varchar2(10)      ,/* 產品類別 */
fmnf013       varchar2(20)      ,/* 人員 */
fmnf014       varchar2(20)      ,/* 專案代號 */
fmnf015       varchar2(30)      ,/* WBS編號 */
fmnf016       varchar2(10)      ,/* 經營方式 */
fmnf017       varchar2(10)      ,/* 渠道 */
fmnf018       varchar2(10)      ,/* 品牌 */
fmnf019       varchar2(30)      ,/* 自由核算項一 */
fmnf020       varchar2(30)      ,/* 自由核算項二 */
fmnf021       varchar2(30)      ,/* 自由核算項三 */
fmnf022       varchar2(30)      ,/* 自由核算項四 */
fmnf023       varchar2(30)      ,/* 自由核算項五 */
fmnf024       varchar2(30)      ,/* 自由核算項六 */
fmnf025       varchar2(30)      ,/* 自由核算項七 */
fmnf026       varchar2(30)      ,/* 自由核算項八 */
fmnf027       varchar2(30)      ,/* 自由核算項九 */
fmnf028       varchar2(30)      ,/* 自由核算項十 */
fmnf029       varchar2(24)      ,/* 收入科目 */
fmnf030       varchar2(24)      ,/* 利息費用科目 */
fmnf031       varchar2(24)      ,/* 對方科目 */
fmnf100       varchar2(10)      ,/* 幣別 */
fmnf101       number(20,6)      ,/* 平倉收入金額 */
fmnf102       number(20,6)      ,/* 利息/費用金額 */
fmnf111       number(20,10)      ,/* 匯率一 */
fmnf112       number(20,6)      ,/* 本幣一平倉收入金額 */
fmnf113       number(20,6)      ,/* 本幣一利息/費用金額 */
fmnf121       number(20,10)      ,/* 匯率二 */
fmnf122       number(20,6)      ,/* 本幣二平倉收入金額 */
fmnf123       number(20,6)      ,/* 本幣二利息/費用金額 */
fmnf131       number(20,10)      ,/* 匯率三 */
fmnf132       number(20,6)      ,/* 本幣三平倉輸入金額 */
fmnf133       number(20,6)      ,/* 本幣三利息/費用金額 */
fmnfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmnfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmnfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmnfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmnfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmnfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmnfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmnfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmnfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmnfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmnfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmnfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmnfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmnfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmnfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmnfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmnfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmnfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmnfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmnfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmnfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmnfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmnfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmnfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmnfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmnfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmnfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmnfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmnfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmnfud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmnf032       varchar2(255)      ,/* 摘要 */
fmnf033       varchar2(10)      ,/* 現金變動碼 */
fmnf034       varchar2(10)      ,/* 存提碼 */
fmnf035       number(20,10)      ,/* 科目二匯率 */
fmnf036       number(20,6)      ,/* 匯差金額 */
fmnf037       number(20,6)      ,/* 銀存金額 */
fmnf038       number(20,10)      ,/* 銀存匯率 */
fmnf039       number(20,6)      /* 銀存科目本幣金額 */
);
alter table fmnf_t add constraint fmnf_pk primary key (fmnfent,fmnfdocno,fmnfseq) enable validate;

create unique index fmnf_pk on fmnf_t (fmnfent,fmnfdocno,fmnfseq);

grant select on fmnf_t to tiptop;
grant update on fmnf_t to tiptop;
grant delete on fmnf_t to tiptop;
grant insert on fmnf_t to tiptop;

exit;
