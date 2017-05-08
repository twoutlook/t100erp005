/* 
================================================================================
檔案代號:bmla_t
檔案名稱:FAS組合設定單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bmla_t
(
bmlaent       number(5)      ,/* 企業編號 */
bmla001       varchar2(40)      ,/* 範本主件料號 */
bmla002       varchar2(30)      ,/* 特性 */
bmla003       varchar2(10)      ,/* 料號分隔碼 */
bmla004       varchar2(10)      ,/* 品名分隔碼 */
bmla005       varchar2(10)      ,/* 規格分隔碼 */
bmlaownid       varchar2(20)      ,/* 資料所有者 */
bmlaowndp       varchar2(10)      ,/* 資料所屬部門 */
bmlacrtid       varchar2(20)      ,/* 資料建立者 */
bmlacrtdp       varchar2(10)      ,/* 資料建立部門 */
bmlacrtdt       timestamp(0)      ,/* 資料創建日 */
bmlamodid       varchar2(20)      ,/* 資料修改者 */
bmlamoddt       timestamp(0)      ,/* 最近修改日 */
bmlaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmlaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmlaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmlaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmlaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmlaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmlaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmlaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmlaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmlaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmlaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmlaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmlaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmlaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmlaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmlaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmlaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmlaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmlaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmlaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmlaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmlaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmlaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmlaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmlaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmlaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmlaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmlaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmlaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmlaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmla_t add constraint bmla_pk primary key (bmlaent,bmla001,bmla002) enable validate;

create unique index bmla_pk on bmla_t (bmlaent,bmla001,bmla002);

grant select on bmla_t to tiptop;
grant update on bmla_t to tiptop;
grant delete on bmla_t to tiptop;
grant insert on bmla_t to tiptop;

exit;
