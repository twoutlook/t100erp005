/* 
================================================================================
檔案代號:rtca_t
檔案名稱:預算指標參數設定維護檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtca_t
(
rtcaent       number(5)      ,/* 企業編號 */
rtca001       varchar2(10)      ,/* 指標編號 */
rtca002       varchar2(10)      ,/* 組別編號 */
rtca003       varchar2(10)      ,/* 性質 */
rtca004       varchar2(10)      ,/* 彙總指標 */
rtca005       varchar2(1)      ,/* KPI */
rtca006       varchar2(1)      ,/* 有效否 */
rtcaownid       varchar2(20)      ,/* 資料所有者 */
rtcaowndp       varchar2(10)      ,/* 資料所屬部門 */
rtcacrtid       varchar2(20)      ,/* 資料建立者 */
rtcacrtdp       varchar2(10)      ,/* 資料建立部門 */
rtcacrtdt       timestamp(0)      ,/* 資料創建日 */
rtcamodid       varchar2(20)      ,/* 資料修改者 */
rtcamoddt       timestamp(0)      ,/* 最近修改日 */
rtcastus       varchar2(10)      ,/* 狀態碼 */
rtcaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtcaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtcaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtcaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtcaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtcaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtcaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtcaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtcaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtcaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtcaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtcaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtcaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtcaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtcaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtcaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtcaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtcaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtcaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtcaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtcaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtcaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtcaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtcaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtcaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtcaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtcaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtcaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtcaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtcaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtca_t add constraint rtca_pk primary key (rtcaent,rtca001) enable validate;

create unique index rtca_pk on rtca_t (rtcaent,rtca001);

grant select on rtca_t to tiptop;
grant update on rtca_t to tiptop;
grant delete on rtca_t to tiptop;
grant insert on rtca_t to tiptop;

exit;
