/* 
================================================================================
檔案代號:oock_t
檔案名稱:縣市檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oock_t
(
oockstus       varchar2(10)      ,/* 狀態碼 */
oockent       number(5)      ,/* 企業編號 */
oock001       varchar2(10)      ,/* 所在國家 */
oock002       varchar2(10)      ,/* 州省編號 */
oock003       varchar2(10)      ,/* 縣市編號 */
oockownid       varchar2(20)      ,/* 資料所有者 */
oockowndp       varchar2(10)      ,/* 資料所屬部門 */
oockcrtid       varchar2(20)      ,/* 資料建立者 */
oockcrtdp       varchar2(10)      ,/* 資料建立部門 */
oockcrtdt       timestamp(0)      ,/* 資料創建日 */
oockmodid       varchar2(20)      ,/* 資料修改者 */
oockmoddt       timestamp(0)      ,/* 最近修改日 */
oockud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oockud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oockud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oockud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oockud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oockud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oockud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oockud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oockud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oockud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oockud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oockud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oockud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oockud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oockud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oockud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oockud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oockud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oockud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oockud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oockud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oockud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oockud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oockud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oockud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oockud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oockud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oockud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oockud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oockud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oock_t add constraint oock_pk primary key (oockent,oock001,oock002,oock003) enable validate;

create unique index oock_pk on oock_t (oockent,oock001,oock002,oock003);

grant select on oock_t to tiptop;
grant update on oock_t to tiptop;
grant delete on oock_t to tiptop;
grant insert on oock_t to tiptop;

exit;
