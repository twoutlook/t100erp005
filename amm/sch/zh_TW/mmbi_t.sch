/* 
================================================================================
檔案代號:mmbi_t
檔案名稱:會員卡積點調整單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmbi_t
(
mmbient       number(5)      ,/* 企業編號 */
mmbidocno       varchar2(20)      ,/* 單據編號 */
mmbisite       varchar2(10)      ,/* 營運據點 */
mmbiunit       varchar2(10)      ,/* 應用組織 */
mmbiseq       number(10,0)      ,/* 項次 */
mmbi001       varchar2(10)      ,/* NO USE */
mmbi002       varchar2(30)      ,/* 會員卡號 */
mmbi003       varchar2(10)      ,/* 卡種編號 */
mmbi004       varchar2(30)      ,/* 會員編號 */
mmbi005       varchar2(20)      ,/* 發票號碼 */
mmbi006       number(20,6)      ,/* 消費金額 */
mmbi007       date      ,/* 有效期至 */
mmbi008       number(15,3)      ,/* 調整積點 */
mmbi009       varchar2(10)      ,/* 理由碼 */
mmbiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmbi_t add constraint mmbi_pk primary key (mmbient,mmbidocno,mmbiseq) enable validate;

create unique index mmbi_pk on mmbi_t (mmbient,mmbidocno,mmbiseq);

grant select on mmbi_t to tiptop;
grant update on mmbi_t to tiptop;
grant delete on mmbi_t to tiptop;
grant insert on mmbi_t to tiptop;

exit;
