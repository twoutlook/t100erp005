/* 
================================================================================
檔案代號:pmac_t
檔案名稱:交易對象交易夥伴檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmac_t
(
pmacent       number(5)      ,/* 企業編號 */
pmac001       varchar2(10)      ,/* 交易對象編號 */
pmac002       varchar2(10)      ,/* 交易夥伴編號 */
pmac003       varchar2(1)      ,/* 交易類型 */
pmac004       varchar2(1)      ,/* 主要否 */
pmacstus       varchar2(10)      ,/* 狀態碼 */
pmacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmac_t add constraint pmac_pk primary key (pmacent,pmac001,pmac002,pmac003) enable validate;

create unique index pmac_pk on pmac_t (pmacent,pmac001,pmac002,pmac003);

grant select on pmac_t to tiptop;
grant update on pmac_t to tiptop;
grant delete on pmac_t to tiptop;
grant insert on pmac_t to tiptop;

exit;
