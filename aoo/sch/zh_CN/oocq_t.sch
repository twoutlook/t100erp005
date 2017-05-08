/* 
================================================================================
檔案代號:oocq_t
檔案名稱:應用分類碼檔(ACC)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oocq_t
(
oocqent       number(5)      ,/* 企業編號 */
oocqstus       varchar2(10)      ,/* 狀態碼 */
oocq001       number(5)      ,/* 應用分類 */
oocq002       varchar2(10)      ,/* 應用分類碼 */
oocq003       varchar2(10)      ,/* 上層應用分類碼 */
oocq004       varchar2(40)      ,/* 參考欄位一 */
oocq005       varchar2(40)      ,/* 參考欄位二 */
oocq006       varchar2(40)      ,/* 參考欄位三 */
oocq007       varchar2(40)      ,/* 參考欄位四 */
oocq008       varchar2(40)      ,/* 參考欄位五 */
oocq009       varchar2(40)      ,/* 參考欄位六 */
oocq010       varchar2(40)      ,/* 參考欄位七 */
oocq011       varchar2(40)      ,/* 參考欄位八 */
oocq012       varchar2(40)      ,/* 參考欄位九 */
oocq013       varchar2(40)      ,/* 參考欄位十 */
oocq014       varchar2(40)      ,/* 參考欄位十一 */
oocq015       varchar2(40)      ,/* 參考欄位十二 */
oocq016       varchar2(40)      ,/* 參考欄位十三 */
oocq017       varchar2(40)      ,/* 參考欄位十四 */
oocq018       varchar2(40)      ,/* 參考欄位十五 */
oocq019       varchar2(40)      ,/* 參考欄位十六 */
oocq020       varchar2(40)      ,/* 參考欄位十七 */
oocq021       varchar2(40)      ,/* 參考欄位十八 */
oocq022       varchar2(40)      ,/* 參考欄位十九 */
oocq023       varchar2(40)      ,/* 參考欄位二十 */
oocqownid       varchar2(20)      ,/* 資料所有者 */
oocqowndp       varchar2(10)      ,/* 資料所屬部門 */
oocqcrtid       varchar2(20)      ,/* 資料建立者 */
oocqcrtdp       varchar2(10)      ,/* 資料建立部門 */
oocqcrtdt       timestamp(0)      ,/* 資料創建日 */
oocqmodid       varchar2(20)      ,/* 資料修改者 */
oocqmoddt       timestamp(0)      ,/* 最近修改日 */
oocq024       varchar2(40)      ,/* 客製參考欄位一 */
oocq025       varchar2(40)      ,/* 客製參考欄位二 */
oocq026       varchar2(40)      ,/* 客製參考欄位三 */
oocq027       varchar2(40)      ,/* 客製參考欄位四 */
oocq028       varchar2(40)      ,/* 客製參考欄位五 */
oocq029       varchar2(40)      ,/* 客製參考欄位六 */
oocq030       varchar2(40)      ,/* 客製參考欄位七 */
oocq031       varchar2(40)      ,/* 客製參考欄位八 */
oocq032       varchar2(40)      ,/* 客製參考欄位九 */
oocq033       varchar2(40)      ,/* 客製參考欄位十 */
oocq034       varchar2(40)      ,/* 客製參考欄位十一 */
oocq035       varchar2(40)      ,/* 客製參考欄位十二 */
oocq036       varchar2(40)      ,/* 客製參考欄位十三 */
oocq037       varchar2(40)      ,/* 客製參考欄位十四 */
oocq038       varchar2(40)      ,/* 客製參考欄位十五 */
oocq039       varchar2(40)      ,/* 客製參考欄位十六 */
oocq040       varchar2(40)      ,/* 客製參考欄位十七 */
oocq041       varchar2(40)      ,/* 客製參考欄位十八 */
oocq042       varchar2(40)      ,/* 客製參考欄位十九 */
oocq043       varchar2(40)      ,/* 客製參考欄位二十 */
oocqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oocqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oocqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oocqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oocqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oocqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oocqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oocqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oocqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oocqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oocqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oocqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oocqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oocqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oocqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oocqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oocqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oocqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oocqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oocqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oocqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oocqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oocqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oocqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oocqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oocqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oocqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oocqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oocqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oocqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oocq_t add constraint oocq_pk primary key (oocqent,oocq001,oocq002) enable validate;

create  index oocq_01 on oocq_t (oocq002);
create unique index oocq_pk on oocq_t (oocqent,oocq001,oocq002);

grant select on oocq_t to tiptop;
grant update on oocq_t to tiptop;
grant delete on oocq_t to tiptop;
grant insert on oocq_t to tiptop;

exit;
