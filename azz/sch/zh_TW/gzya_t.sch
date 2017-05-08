/* 
================================================================================
檔案代號:gzya_t
檔案名稱:職能角色定義表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzya_t
(
gzyastus       varchar2(10)      ,/* 狀態碼 */
gzyaent       number(5)      ,/* 企業編號 */
gzya001       varchar2(10)      ,/* 職能角色編號 */
gzya002       varchar2(1)      ,/* 使用標示 */
gzyaownid       varchar2(20)      ,/* 資料所有者 */
gzyaowndp       varchar2(10)      ,/* 資料所屬部門 */
gzyacrtid       varchar2(20)      ,/* 資料建立者 */
gzyacrtdp       varchar2(10)      ,/* 資料建立部門 */
gzyacrtdt       timestamp(0)      ,/* 資料創建日 */
gzyamodid       varchar2(20)      ,/* 資料修改者 */
gzyamoddt       timestamp(0)      ,/* 最近修改日 */
gzyaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzyaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzyaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzyaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzyaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzyaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzyaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzyaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzyaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzyaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzyaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzyaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzyaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzyaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzyaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzyaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzyaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzyaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzyaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzyaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzyaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzyaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzyaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzyaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzyaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzyaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzyaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzyaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzyaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzyaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gzya003       varchar2(1)      /* 屬於superuser群組 */
);
alter table gzya_t add constraint gzya_pk primary key (gzyaent,gzya001) enable validate;

create unique index gzya_pk on gzya_t (gzyaent,gzya001);

grant select on gzya_t to tiptop;
grant update on gzya_t to tiptop;
grant delete on gzya_t to tiptop;
grant insert on gzya_t to tiptop;

exit;
