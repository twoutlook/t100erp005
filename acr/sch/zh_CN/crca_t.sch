/* 
================================================================================
檔案代號:crca_t
檔案名稱:客戶提醒基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table crca_t
(
crcaent       number(5)      ,/* 企業編號 */
crcastus       varchar2(1)      ,/* 狀態 */
crcaseq       number(10,0)      ,/* 項次 */
crca001       varchar2(10)      ,/* 客戶編號 */
crca002       varchar2(30)      ,/* 會員卡號 */
crca003       varchar2(30)      ,/* 會員編號 */
crca004       varchar2(40)      ,/* 車牌號 */
crca005       date      ,/* 提醒失效日期 */
crca006       varchar2(500)      ,/* 提醒內容 */
crca007       varchar2(1)      ,/* 已提醒 */
crca008       number(5,0)      ,/* 提醒次數 */
crca009       varchar2(20)      ,/* 手機號碼 */
crca010       varchar2(1)      ,/* 提醒類型 */
crca011       varchar2(40)      ,/* 備用一 */
crca012       varchar2(40)      ,/* 備用二 */
crca013       varchar2(40)      ,/* 備用三 */
crca014       varchar2(40)      ,/* 備用四 */
crca015       varchar2(40)      ,/* 備用五 */
crcaownid       varchar2(20)      ,/* 資料所有者 */
crcaowndp       varchar2(10)      ,/* 資料所屬部門 */
crcacrtid       varchar2(20)      ,/* 資料建立者 */
crcacrtdp       varchar2(10)      ,/* 資料建立部門 */
crcacrtdt       timestamp(0)      ,/* 資料創建日 */
crcamodid       varchar2(20)      ,/* 資料修改者 */
crcamoddt       timestamp(0)      ,/* 最近修改日 */
crcaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
crcaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
crcaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
crcaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
crcaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
crcaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
crcaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
crcaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
crcaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
crcaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
crcaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
crcaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
crcaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
crcaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
crcaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
crcaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
crcaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
crcaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
crcaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
crcaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
crcaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
crcaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
crcaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
crcaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
crcaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
crcaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
crcaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
crcaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
crcaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
crcaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crca_t add constraint crca_pk primary key (crcaent,crcaseq,crca001) enable validate;

create unique index crca_pk on crca_t (crcaent,crcaseq,crca001);

grant select on crca_t to tiptop;
grant update on crca_t to tiptop;
grant delete on crca_t to tiptop;
grant insert on crca_t to tiptop;

exit;
