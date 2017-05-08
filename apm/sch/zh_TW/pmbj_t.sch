/* 
================================================================================
檔案代號:pmbj_t
檔案名稱:交易對象聯絡人申請檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmbj_t
(
pmbjent       number(5)      ,/* 企業編號 */
pmbjdocno       varchar2(20)      ,/* 申請單號 */
pmbj001       varchar2(10)      ,/* 交易對象編號 */
pmbj002       varchar2(20)      ,/* 聯絡人識別碼 */
pmbj003       varchar2(10)      ,/* 聯絡人類別 */
pmbj004       varchar2(1)      ,/* 主要聯絡人否 */
pmbj005       varchar2(1)      ,/* 財務主要聯絡人否 */
pmbj006       varchar2(80)      ,/* 聯絡人部門 */
pmbj007       varchar2(80)      ,/* 職稱 */
pmbj008       varchar2(255)      ,/* 簡要說明 */
pmbjstus       varchar2(10)      ,/* 狀態碼 */
pmbj009       varchar2(80)      ,/* 姓氏 */
pmbj010       varchar2(80)      ,/* 中間名 */
pmbj011       varchar2(80)      ,/* 名字 */
pmbj012       varchar2(255)      ,/* 全名 */
pmbj013       varchar2(80)      ,/* 參考名 */
pmbj014       varchar2(80)      ,/* 暱稱 */
pmbjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbjud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmbj015       varchar2(20)      /* 修改前的聯絡對象識別碼 */
);
alter table pmbj_t add constraint pmbj_pk primary key (pmbjent,pmbjdocno,pmbj002) enable validate;

create unique index pmbj_pk on pmbj_t (pmbjent,pmbjdocno,pmbj002);

grant select on pmbj_t to tiptop;
grant update on pmbj_t to tiptop;
grant delete on pmbj_t to tiptop;
grant insert on pmbj_t to tiptop;

exit;
