/* 
================================================================================
檔案代號:isao_t
檔案名稱:營運據點開立發票資料設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table isao_t
(
isaoent       number(5)      ,/* 企業編號 */
isaosite       varchar2(10)      ,/* 營運據點 */
isao001       varchar2(20)      ,/* 納稅人識別號 */
isao002       varchar2(4000)      ,/* 開立發票地址 */
isao003       varchar2(80)      ,/* 開立發票電話 */
isao004       varchar2(255)      ,/* 開立發票銀行名稱 */
isao005       varchar2(30)      ,/* 開立發票銀行帳號 */
isao006       varchar2(1)      ,/* 防偽稅控接口開立否 */
isao007       varchar2(1)      ,/* 防偽稅控進項開立否 */
isao008       varchar2(1)      ,/* 防偽稅控銷項開立否 */
isao009       varchar2(1)      ,/* 使用工商憑證否 */
isao010       varchar2(80)      ,/* 電子發票加密金鑰 */
isao011       varchar2(10)      ,/* 第三方加值服務中心 */
isao012       varchar2(1)      ,/* 接收發票方式 */
isao013       varchar2(80)      ,/* 營業人Email */
isao014       varchar2(5)      ,/* 慣用發票單別 */
isao015       varchar2(5)      ,/* 慣用折單單別 */
isao016       varchar2(1)      ,/* 出貨單開立發票同時產生應收單 */
isaostus       varchar2(1)      ,/* 狀態碼 */
isaoownid       varchar2(20)      ,/* 資料所有者 */
isaoowndp       varchar2(10)      ,/* 資料所屬部門 */
isaocrtid       varchar2(20)      ,/* 資料建立者 */
isaocrtdp       varchar2(10)      ,/* 資料建立部門 */
isaocrtdt       timestamp(0)      ,/* 資料創建日 */
isaomodid       varchar2(20)      ,/* 資料修改者 */
isaomoddt       timestamp(0)      ,/* 最近修改日 */
isaoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isaoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isaoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isaoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isaoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isaoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isaoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isaoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isaoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isaoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isaoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isaoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isaoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isaoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isaoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isaoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isaoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isaoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isaoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isaoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isaoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isaoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isaoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isaoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isaoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isaoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isaoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isaoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isaoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isaoud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
isao017       varchar2(1)      /* 使用電子發票否 */
);
alter table isao_t add constraint isao_pk primary key (isaoent,isaosite) enable validate;

create unique index isao_pk on isao_t (isaoent,isaosite);

grant select on isao_t to tiptop;
grant update on isao_t to tiptop;
grant delete on isao_t to tiptop;
grant insert on isao_t to tiptop;

exit;
