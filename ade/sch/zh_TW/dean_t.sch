/* 
================================================================================
檔案代號:dean_t
檔案名稱:營業款保全代收存繳單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table dean_t
(
deanent       number(5)      ,/* 企業編號 */
deansite       varchar2(10)      ,/* 營運據點 */
deanunit       varchar2(10)      ,/* 應用組織 */
deandocno       varchar2(20)      ,/* 存繳單號 */
deanseq       number(10,0)      ,/* 項次 */
dean001       date      ,/* 營業日期 */
dean002       varchar2(10)      ,/* 款別分類 */
dean003       varchar2(10)      ,/* 款別編號 */
dean004       varchar2(10)      ,/* 卡券種編號 */
dean005       varchar2(10)      ,/* 券面額編號 */
dean006       varchar2(10)      ,/* 幣別 */
dean007       number(20,6)      ,/* 代收數量 */
dean008       number(20,6)      ,/* 代收金額 */
dean009       varchar2(20)      ,/* 支票號碼 */
deanud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deanud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deanud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deanud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deanud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deanud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deanud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deanud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deanud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deanud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deanud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deanud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deanud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deanud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deanud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deanud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deanud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deanud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deanud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deanud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deanud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deanud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deanud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deanud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deanud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deanud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deanud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deanud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deanud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deanud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dean_t add constraint dean_pk primary key (deanent,deandocno,deanseq) enable validate;

create unique index dean_pk on dean_t (deanent,deandocno,deanseq);

grant select on dean_t to tiptop;
grant update on dean_t to tiptop;
grant delete on dean_t to tiptop;
grant insert on dean_t to tiptop;

exit;
