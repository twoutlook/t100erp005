/* 
================================================================================
檔案代號:fmcw_t
檔案名稱:償還本息單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmcw_t
(
fmcwent       number(5)      ,/* 企業編號 */
fmcwdocno       varchar2(20)      ,/* 還款單編號 */
fmcwseq       number(10,0)      ,/* 項次 */
fmcw001       varchar2(10)      ,/* 融資組織 */
fmcw002       varchar2(20)      ,/* 融資合同號 */
fmcw003       number(10,0)      ,/* 融資合同項次 */
fmcw004       varchar2(1)      ,/* 還款性質 */
fmcw005       varchar2(10)      ,/* 幣別 */
fmcw006       number(20,6)      ,/* 本/息金額 */
fmcw007       varchar2(10)      ,/* 還款帳戶 */
fmcw008       varchar2(1)      ,/* 異動別 */
fmcw009       varchar2(10)      ,/* 存提碼 */
fmcw010       number(20,10)      ,/* 匯率 */
fmcw011       number(20,6)      ,/* 本幣 */
fmcw012       number(20,10)      ,/* 匯率二 */
fmcw013       number(20,6)      ,/* 本幣二 */
fmcw014       number(20,10)      ,/* 匯率三 */
fmcw015       number(20,6)      ,/* 本幣三 */
fmcw016       varchar2(10)      ,/* 現金變動碼 */
fmcw017       number(20,6)      ,/* 已計提未支付利息 */
fmcw018       number(20,10)      ,/* 歷史匯率 */
fmcw019       number(20,10)      ,/* 歷史匯率二 */
fmcw020       number(20,10)      ,/* 歷史匯率三 */
fmcw021       varchar2(20)      ,/* 融資到帳單號 */
fmcw022       number(10,0)      ,/* 融資到帳單項次 */
fmcw023       number(20,6)      ,/* 本幣匯差 */
fmcw024       number(20,6)      ,/* 本幣匯差二 */
fmcw025       number(20,6)      ,/* 本幣匯差三 */
fmcwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmcwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmcwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmcwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmcwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmcwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmcwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmcwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmcwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmcwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmcwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmcwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmcwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmcwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmcwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmcwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmcwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmcwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmcwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmcwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmcwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmcwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmcwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmcwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmcwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmcwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmcwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmcwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmcwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmcwud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmcw026       varchar2(255)      /* 摘要 */
);
alter table fmcw_t add constraint fmcw_pk primary key (fmcwent,fmcwdocno,fmcwseq) enable validate;

create unique index fmcw_pk on fmcw_t (fmcwent,fmcwdocno,fmcwseq);

grant select on fmcw_t to tiptop;
grant update on fmcw_t to tiptop;
grant delete on fmcw_t to tiptop;
grant insert on fmcw_t to tiptop;

exit;
