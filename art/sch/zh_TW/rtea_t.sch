/* 
================================================================================
檔案代號:rtea_t
檔案名稱:競爭門店資料維護表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtea_t
(
rteaent       number(5)      ,/* 企業編號 */
rtea001       varchar2(10)      ,/* 市調門店 */
rtea002       varchar2(10)      ,/* 競爭門店編號 */
rtea003       varchar2(80)      ,/* 競爭門店名稱 */
rtea004       number(10,0)      ,/* 競爭門店面積(平米) */
rtea005       number(10,0)      ,/* 競爭門店人數 */
rtea006       varchar2(255)      ,/* 競爭門店地址 */
rtea007       varchar2(4000)      ,/* 備註 */
rteastus       varchar2(10)      ,/* 狀態 */
rteaownid       varchar2(20)      ,/* 資料所有者 */
rteaowndp       varchar2(10)      ,/* 資料所屬部門 */
rteacrtid       varchar2(20)      ,/* 資料建立者 */
rteacrtdp       varchar2(10)      ,/* 資料建立部門 */
rteacrtdt       timestamp(0)      ,/* 資料創建日 */
rteamodid       varchar2(20)      ,/* 資料修改者 */
rteamoddt       timestamp(0)      ,/* 最近修改日 */
rteaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rteaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rteaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rteaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rteaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rteaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rteaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rteaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rteaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rteaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rteaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rteaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rteaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rteaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rteaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rteaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rteaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rteaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rteaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rteaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rteaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rteaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rteaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rteaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rteaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rteaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rteaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rteaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rteaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rteaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtea_t add constraint rtea_pk primary key (rteaent,rtea001,rtea002) enable validate;

create unique index rtea_pk on rtea_t (rteaent,rtea001,rtea002);

grant select on rtea_t to tiptop;
grant update on rtea_t to tiptop;
grant delete on rtea_t to tiptop;
grant insert on rtea_t to tiptop;

exit;
