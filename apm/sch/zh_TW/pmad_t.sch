/* 
================================================================================
檔案代號:pmad_t
檔案名稱:交易對象允許收/付款條件檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmad_t
(
pmadent       number(5)      ,/* 企業編號 */
pmad001       varchar2(10)      ,/* 交易對象編號 */
pmad002       varchar2(10)      ,/* 交易條件編號 */
pmad003       varchar2(10)      ,/* 交易類型 */
pmad004       varchar2(1)      ,/* 主要否 */
pmadstus       varchar2(10)      ,/* 狀態碼 */
pmadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmad_t add constraint pmad_pk primary key (pmadent,pmad001,pmad002) enable validate;

create unique index pmad_pk on pmad_t (pmadent,pmad001,pmad002);

grant select on pmad_t to tiptop;
grant update on pmad_t to tiptop;
grant delete on pmad_t to tiptop;
grant insert on pmad_t to tiptop;

exit;
