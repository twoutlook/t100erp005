/* 
================================================================================
檔案代號:inar_t
檔案名稱:庫存需求等候歷史明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inar_t
(
inarent       number(5)      ,/* 企業編號 */
inarsite       varchar2(10)      ,/* 營運據點 */
inar001       varchar2(20)      ,/* 單據編號 */
inar002       number(10,0)      ,/* 單據項次 */
inar003       number(10,0)      ,/* 單據項序 */
inar004       number(10,0)      ,/* 單據分批序 */
inar005       timestamp(0)      ,/* 排隊日期時間 */
inar006       timestamp(0)      ,/* 調整後排隊日期時間 */
inar007       varchar2(10)      ,/* 單據性質 */
inar008       varchar2(20)      ,/* 作業編號 */
inar009       varchar2(40)      ,/* 料件編號 */
inar010       varchar2(256)      ,/* 產品特徵 */
inar011       varchar2(10)      ,/* 交易單位 */
inar012       number(20,6)      ,/* 原始需求數量 */
inar013       date      ,/* 需求日期 */
inar014       varchar2(20)      ,/* 負責人員 */
inar015       varchar2(10)      ,/* 負責部門 */
inarud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inarud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inarud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inarud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inarud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inarud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inarud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inarud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inarud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inarud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inarud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inarud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inarud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inarud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inarud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inarud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inarud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inarud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inarud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inarud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inarud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inarud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inarud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inarud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inarud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inarud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inarud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inarud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inarud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inarud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inar_t add constraint inar_pk primary key (inarent,inarsite,inar001,inar002,inar003,inar004) enable validate;

create unique index inar_pk on inar_t (inarent,inarsite,inar001,inar002,inar003,inar004);

grant select on inar_t to tiptop;
grant update on inar_t to tiptop;
grant delete on inar_t to tiptop;
grant insert on inar_t to tiptop;

exit;
