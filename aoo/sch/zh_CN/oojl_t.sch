/* 
================================================================================
檔案代號:oojl_t
檔案名稱:組織基本資料申請單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table oojl_t
(
oojlent       number(5)      ,/* 企業編號 */
oojlsite       varchar2(10)      ,/* 營運據點 */
oojlunit       varchar2(10)      ,/* 應用組織 */
oojldocno       varchar2(20)      ,/* 單據編號 */
oojldocdt       date      ,/* 單據日期 */
oojl000       varchar2(10)      ,/* 異動類型 */
oojl001       varchar2(10)      ,/* 資料類型 */
oojl002       date      ,/* 異動生效日期 */
oojl003       varchar2(20)      ,/* 申請人員 */
oojl004       varchar2(10)      ,/* 申請部門 */
oojl005       varchar2(1)      ,/* 資料更新成功 */
oojlownid       varchar2(20)      ,/* 資料所有者 */
oojlowndp       varchar2(10)      ,/* 資料所屬部門 */
oojlcrtid       varchar2(20)      ,/* 資料建立者 */
oojlcrtdp       varchar2(10)      ,/* 資料建立部門 */
oojlcrtdt       timestamp(0)      ,/* 資料創建日 */
oojlmodid       varchar2(20)      ,/* 資料修改者 */
oojlmoddt       timestamp(0)      ,/* 最近修改日 */
oojlcnfid       varchar2(20)      ,/* 資料確認者 */
oojlcnfdt       timestamp(0)      ,/* 資料確認日 */
oojlstus       varchar2(10)      ,/* 狀態碼 */
oojlud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oojlud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oojlud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oojlud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oojlud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oojlud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oojlud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oojlud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oojlud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oojlud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oojlud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oojlud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oojlud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oojlud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oojlud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oojlud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oojlud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oojlud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oojlud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oojlud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oojlud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oojlud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oojlud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oojlud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oojlud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oojlud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oojlud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oojlud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oojlud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oojlud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oojl_t add constraint oojl_pk primary key (oojlent,oojldocno) enable validate;

create unique index oojl_pk on oojl_t (oojlent,oojldocno);

grant select on oojl_t to tiptop;
grant update on oojl_t to tiptop;
grant delete on oojl_t to tiptop;
grant insert on oojl_t to tiptop;

exit;
