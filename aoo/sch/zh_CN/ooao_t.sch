/* 
================================================================================
檔案代號:ooao_t
檔案名稱:月匯率資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooao_t
(
ooaoent       number(5)      ,/* 企業編號 */
ooao001       varchar2(5)      ,/* 匯率參照表號 */
ooao002       varchar2(10)      ,/* 交易幣別 */
ooao003       varchar2(10)      ,/* 基礎幣別 */
ooao004       varchar2(10)      ,/* 年月 */
ooao005       number(20,10)      ,/* 銀行買入匯率 */
ooao006       number(20,10)      ,/* 銀行賣出匯率 */
ooao007       number(20,10)      ,/* 銀行中價匯率 */
ooao008       number(20,10)      ,/* 海關買入匯率 */
ooao009       number(20,10)      ,/* 海關賣出匯率 */
ooao010       number(20,10)      ,/* 外匯收盤匯率 */
ooao011       number(20,10)      ,/* 重評價匯率 */
ooao012       timestamp(0)      ,/* 更新時間 */
ooao013       varchar2(10)      ,/* 更新方式 */
ooao014       number(20,6)      ,/* 交易貨幣批量 */
ooao015       varchar2(10)      ,/* 匯率輸入方式 */
ooaoownid       varchar2(20)      ,/* 資料所有者 */
ooaoowndp       varchar2(10)      ,/* 資料所屬部門 */
ooaocrtid       varchar2(20)      ,/* 資料建立者 */
ooaocrtdp       varchar2(10)      ,/* 資料建立部門 */
ooaocrtdt       timestamp(0)      ,/* 資料創建日 */
ooaomodid       varchar2(20)      ,/* 資料修改者 */
ooaomoddt       timestamp(0)      ,/* 最近修改日 */
ooaostus       varchar2(10)      ,/* 狀態碼 */
ooaoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooaoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooaoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooaoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooaoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooaoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooaoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooaoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooaoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooaoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooaoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooaoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooaoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooaoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooaoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooaoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooaoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooaoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooaoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooaoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooaoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooaoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooaoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooaoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooaoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooaoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooaoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooaoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooaoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooaoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooao_t add constraint ooao_pk primary key (ooaoent,ooao001,ooao002,ooao003,ooao004) enable validate;

create unique index ooao_pk on ooao_t (ooaoent,ooao001,ooao002,ooao003,ooao004);

grant select on ooao_t to tiptop;
grant update on ooao_t to tiptop;
grant delete on ooao_t to tiptop;
grant insert on ooao_t to tiptop;

exit;
