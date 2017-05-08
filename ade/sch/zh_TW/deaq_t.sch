/* 
================================================================================
檔案代號:deaq_t
檔案名稱:門店收銀備用金領用單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table deaq_t
(
deaqent       number(5)      ,/* 企業編號 */
deaqsite       varchar2(10)      ,/* 營運據點 */
deaqunit       varchar2(10)      ,/* 應用組織 */
deaqdocno       varchar2(20)      ,/* 單據編號 */
deaqdocdt       date      ,/* 單據日期 */
deaq001       varchar2(10)      ,/* 班別 */
deaqownid       varchar2(20)      ,/* 資料所有者 */
deaqowndp       varchar2(10)      ,/* 資料所屬部門 */
deaqcrtid       varchar2(20)      ,/* 資料建立者 */
deaqcrtdp       varchar2(10)      ,/* 資料建立部門 */
deaqcrtdt       timestamp(0)      ,/* 資料創建日 */
deaqmodid       varchar2(20)      ,/* 資料修改者 */
deaqmoddt       timestamp(0)      ,/* 最近修改日 */
deaqstus       varchar2(10)      ,/* 狀態碼 */
deaqcnfid       varchar2(20)      ,/* 資料確認者 */
deaqcnfdt       timestamp(0)      ,/* 資料確認日 */
deaqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deaqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deaqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deaqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deaqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deaqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deaqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deaqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deaqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deaqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deaqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deaqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deaqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deaqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deaqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deaqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deaqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deaqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deaqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deaqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deaqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deaqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deaqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deaqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deaqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deaqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deaqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deaqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deaqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deaqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deaq_t add constraint deaq_pk primary key (deaqent,deaqdocno) enable validate;

create unique index deaq_pk on deaq_t (deaqent,deaqdocno);

grant select on deaq_t to tiptop;
grant update on deaq_t to tiptop;
grant delete on deaq_t to tiptop;
grant insert on deaq_t to tiptop;

exit;
