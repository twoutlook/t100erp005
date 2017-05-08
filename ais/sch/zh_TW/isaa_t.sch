/* 
================================================================================
檔案代號:isaa_t
檔案名稱:申報單位基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table isaa_t
(
isaaent       number(5)      ,/* 企業編號 */
isaa001       varchar2(10)      ,/* 申報單位代碼 */
isaa002       varchar2(20)      ,/* 申報單位稅務編號 */
isaa003       varchar2(80)      ,/* 負責人姓名 */
isaa004       varchar2(80)      ,/* 電子郵件 */
isaa005       varchar2(20)      ,/* 電話 */
isaa006       varchar2(20)      ,/* 傳真 */
isaa007       varchar2(1)      ,/* 申報週期 */
isaa008       varchar2(1)      ,/* 總繳代號 */
isaa009       varchar2(10)      ,/* 總機構代碼 */
isaa010       varchar2(1)      ,/* 自行委託辦理申報註記 */
isaa011       varchar2(20)      ,/* 電子發票加密金鑰 */
isaa012       number(5,0)      ,/* 申報年度 */
isaa013       number(5,0)      ,/* 申報月份 */
isaa014       varchar2(10)      ,/* 代理人交易對象代碼 */
isaa015       varchar2(20)      ,/* 代理人統一編號 */
isaa016       varchar2(255)      ,/* 代理人機構名稱 */
isaa017       varchar2(20)      ,/* 代理人電話 */
isaa018       varchar2(4000)      ,/* 代理人地址 */
isaa019       varchar2(80)      ,/* 代理承辦人姓名 */
isaa020       varchar2(20)      ,/* 證書登錄字號 */
isaa021       varchar2(80)      ,/* 代理人電子郵件信箱 */
isaastus       varchar2(1)      ,/* 狀態碼 */
isaaownid       varchar2(20)      ,/* 資料所有者 */
isaaowndp       varchar2(10)      ,/* 資料所屬部門 */
isaacrtid       varchar2(20)      ,/* 資料建立者 */
isaacrtdp       varchar2(10)      ,/* 資料建立部門 */
isaacrtdt       timestamp(0)      ,/* 資料創建日 */
isaamodid       varchar2(20)      ,/* 資料修改者 */
isaamoddt       timestamp(0)      ,/* 最近修改日 */
isaa022       varchar2(1)      ,/* 直接扣抵法 */
isaa023       varchar2(1)      ,/* 進銷資料併總公司合併申報 */
isaa024       varchar2(1)      ,/* 使用工商憑證否 */
isaa025       varchar2(10)      ,/* 第三方加值服務中心 */
isaa026       varchar2(1)      ,/* 接收發票方式 */
isaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isaaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
isaa027       varchar2(10)      ,/* 縣市代碼 */
isaa028       varchar2(4)      ,/* 電話區碼 */
isaa029       varchar2(10)      ,/* 電話分機 */
isaa030       varchar2(20)      ,/* 負責人身份證字號 */
isaa031       varchar2(4000)      ,/* 地址 */
isaa032       date      /* 開業日期 */
);
alter table isaa_t add constraint isaa_pk primary key (isaaent,isaa001) enable validate;

create unique index isaa_pk on isaa_t (isaaent,isaa001);

grant select on isaa_t to tiptop;
grant update on isaa_t to tiptop;
grant delete on isaa_t to tiptop;
grant insert on isaa_t to tiptop;

exit;
