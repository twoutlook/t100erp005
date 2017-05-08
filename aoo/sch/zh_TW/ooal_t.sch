/* 
================================================================================
檔案代號:ooal_t
檔案名稱:參照表資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooal_t
(
ooalstus       varchar2(1)      ,/* 狀態碼 */
ooalent       number(5)      ,/* 企業編號 */
ooal001       number(5,0)      ,/* 參照表類型 */
ooal002       varchar2(5)      ,/* 參照表編號 */
ooalownid       varchar2(20)      ,/* 資料所有者 */
ooalowndp       varchar2(10)      ,/* 資料所屬部門 */
ooalcrtid       varchar2(20)      ,/* 資料建立者 */
ooalcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooalcrtdt       timestamp(0)      ,/* 資料創建日 */
ooalmodid       varchar2(20)      ,/* 資料修改者 */
ooalmoddt       timestamp(0)      ,/* 最近修改日 */
ooalud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooalud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooalud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooalud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooalud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooalud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooalud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooalud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooalud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooalud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooalud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooalud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooalud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooalud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooalud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooalud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooalud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooalud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooalud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooalud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooalud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooalud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooalud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooalud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooalud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooalud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooalud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooalud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooalud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooalud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooal_t add constraint ooal_pk primary key (ooalent,ooal001,ooal002) enable validate;

create unique index ooal_pk on ooal_t (ooalent,ooal001,ooal002);

grant select on ooal_t to tiptop;
grant update on ooal_t to tiptop;
grant delete on ooal_t to tiptop;
grant insert on ooal_t to tiptop;

exit;
