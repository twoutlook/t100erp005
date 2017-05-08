/* 
================================================================================
檔案代號:bxdo_t
檔案名稱:保稅機器設備年統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bxdo_t
(
bxdoent       number(5)      ,/* 企業編號 */
bxdosite       varchar2(10)      ,/* 營運據點 */
bxdo001       number(5,0)      ,/* 年度 */
bxdo002       varchar2(20)      ,/* 機器設備編號 */
bxdo003       number(20,6)      ,/* 期初數量 */
bxdo004       number(20,6)      ,/* 入庫數 */
bxdo005       number(20,6)      ,/* 外送數 */
bxdo006       number(20,6)      ,/* 報廢數 */
bxdo007       number(20,6)      ,/* 除帳數 */
bxdo008       number(20,6)      ,/* 帳面結存數 */
bxdo009       number(20,6)      ,/* 盤存數 */
bxdo010       number(20,6)      ,/* 期末數 */
bxdoownid       varchar2(20)      ,/* 資料所有者 */
bxdoowndp       varchar2(10)      ,/* 資料所屬部門 */
bxdocrtid       varchar2(20)      ,/* 資料建立者 */
bxdocrtdp       varchar2(10)      ,/* 資料建立部門 */
bxdocrtdt       timestamp(0)      ,/* 資料創建日 */
bxdomodid       varchar2(20)      ,/* 資料修改者 */
bxdomoddt       timestamp(0)      ,/* 最近修改日 */
bxdostus       varchar2(10)      ,/* 狀態碼 */
bxdoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxdoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxdoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxdoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxdoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxdoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxdoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxdoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxdoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxdoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxdoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxdoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxdoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxdoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxdoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxdoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxdoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxdoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxdoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxdoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxdoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxdoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxdoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxdoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxdoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxdoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxdoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxdoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxdoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxdoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxdo_t add constraint bxdo_pk primary key (bxdoent,bxdosite,bxdo001,bxdo002) enable validate;

create unique index bxdo_pk on bxdo_t (bxdoent,bxdosite,bxdo001,bxdo002);

grant select on bxdo_t to tiptop;
grant update on bxdo_t to tiptop;
grant delete on bxdo_t to tiptop;
grant insert on bxdo_t to tiptop;

exit;
