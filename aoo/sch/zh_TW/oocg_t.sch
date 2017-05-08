/* 
================================================================================
檔案代號:oocg_t
檔案名稱:國家地區檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oocg_t
(
oocgent       number(5)      ,/* 企業編號 */
oocgstus       varchar2(10)      ,/* 狀態碼 */
oocg001       varchar2(10)      ,/* 國家地區編號 */
oocg002       varchar2(10)      ,/* 所在洲別 */
oocg003       varchar2(10)      ,/* ISO三碼國別 */
oocg004       varchar2(10)      ,/* ISO二碼國別 */
oocg005       varchar2(10)      ,/* ISO數字代碼 */
oocg006       varchar2(10)      ,/* 國際電話代碼 */
oocg007       varchar2(10)      ,/* 全名組合方式 */
oocg008       varchar2(10)      ,/* 地址輸出格式 */
oocg009       varchar2(10)      ,/* 電話控制方式 */
oocgownid       varchar2(20)      ,/* 資料所有者 */
oocgowndp       varchar2(10)      ,/* 資料所屬部門 */
oocgcrtid       varchar2(20)      ,/* 資料建立者 */
oocgcrtdp       varchar2(10)      ,/* 資料建立部門 */
oocgcrtdt       timestamp(0)      ,/* 資料創建日 */
oocgmodid       varchar2(20)      ,/* 資料修改者 */
oocgmoddt       timestamp(0)      ,/* 最近修改日 */
oocg010       varchar2(10)      ,/* 時區 */
oocgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oocgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oocgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oocgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oocgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oocgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oocgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oocgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oocgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oocgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oocgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oocgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oocgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oocgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oocgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oocgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oocgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oocgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oocgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oocgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oocgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oocgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oocgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oocgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oocgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oocgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oocgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oocgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oocgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oocgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oocg_t add constraint oocg_pk primary key (oocgent,oocg001) enable validate;

create unique index oocg_pk on oocg_t (oocgent,oocg001);

grant select on oocg_t to tiptop;
grant update on oocg_t to tiptop;
grant delete on oocg_t to tiptop;
grant insert on oocg_t to tiptop;

exit;
