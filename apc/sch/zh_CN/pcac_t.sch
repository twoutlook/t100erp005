/* 
================================================================================
檔案代號:pcac_t
檔案名稱:收銀人員使用組織及收銀機權限檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table pcac_t
(
pcacent       number(5)      ,/* 企業編號 */
pcacunit       varchar2(10)      ,/* 應用組織 */
pcac001       varchar2(10)      ,/* 收銀人員編號 */
pcac002       varchar2(10)      ,/* 組織編號 */
pcac003       varchar2(10)      ,/* 收銀機編號 */
pcacstus       varchar2(10)      ,/* 狀態碼 */
pcacstamp       timestamp(5)      ,/* 時間戳記 */
pcacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcac_t add constraint pcac_pk primary key (pcacent,pcac001,pcac002,pcac003) enable validate;

create unique index pcac_pk on pcac_t (pcacent,pcac001,pcac002,pcac003);

grant select on pcac_t to tiptop;
grant update on pcac_t to tiptop;
grant delete on pcac_t to tiptop;
grant insert on pcac_t to tiptop;

exit;
