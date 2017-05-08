/* 
================================================================================
檔案代號:isai_t
檔案名稱:稅區參數資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table isai_t
(
isaient       number(5)      ,/* 企業編號 */
isai001       varchar2(10)      ,/* 交易稅區 */
isai002       varchar2(1)      ,/* 發票編碼方式 */
isai003       varchar2(1)      ,/* 紅字發票是否必須對應原始發票 */
isai004       varchar2(1)      ,/* 紅字發票呈現方式 */
isai005       number(5,0)      ,/* 編碼長度 */
isaiownid       varchar2(20)      ,/* 資料所有者 */
isaiowndp       varchar2(10)      ,/* 資料所屬部門 */
isaicrtid       varchar2(20)      ,/* 資料建立者 */
isaicrtdp       varchar2(10)      ,/* 資料建立部門 */
isaicrtdt       timestamp(0)      ,/* 資料創建日 */
isaimodid       varchar2(20)      ,/* 資料修改者 */
isaimoddt       timestamp(0)      ,/* 最近修改日 */
isai006       varchar2(1)      ,/* 紅字發票與藍字發票共用發票簿 */
isai007       varchar2(1)      ,/* 出貨發票列印方式 */
isaistus       varchar2(10)      ,/* 狀態碼 */
isai008       varchar2(10)      ,/* 稅區所屬國家 */
isaiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isaiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isaiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isaiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isaiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isaiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isaiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isaiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isaiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isaiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isaiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isaiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isaiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isaiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isaiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isaiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isaiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isaiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isaiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isaiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isaiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isaiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isaiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isaiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isaiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isaiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isaiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isaiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isaiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isaiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isai_t add constraint isai_pk primary key (isaient,isai001) enable validate;

create unique index isai_pk on isai_t (isaient,isai001);

grant select on isai_t to tiptop;
grant update on isai_t to tiptop;
grant delete on isai_t to tiptop;
grant insert on isai_t to tiptop;

exit;
