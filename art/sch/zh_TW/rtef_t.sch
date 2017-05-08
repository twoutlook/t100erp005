/* 
================================================================================
檔案代號:rtef_t
檔案名稱:專櫃新商品引進單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtef_t
(
rtefent       number(5)      ,/* 企業編號 */
rtefsite       varchar2(10)      ,/* 營運據點 */
rtefunit       varchar2(10)      ,/* 應用組織 */
rtefdocno       varchar2(20)      ,/* 單據編號 */
rtefdocdt       date      ,/* 單據日期 */
rtef000       varchar2(10)      ,/* 作業方式 */
rtef001       varchar2(10)      ,/* 專櫃編號 */
rtef002       varchar2(10)      ,/* 供應商編號 */
rtef003       varchar2(10)      ,/* 業務員編號 */
rtef004       varchar2(255)      ,/* 備註 */
rtefownid       varchar2(20)      ,/* 資料所有者 */
rtefowndp       varchar2(10)      ,/* 資料所屬部門 */
rtefcrtid       varchar2(20)      ,/* 資料建立者 */
rtefcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtefcrtdt       timestamp(0)      ,/* 資料創建日 */
rtefmodid       varchar2(20)      ,/* 資料修改者 */
rtefmoddt       timestamp(0)      ,/* 最近修改日 */
rtefcnfid       varchar2(20)      ,/* 資料確認者 */
rtefcnfdt       timestamp(0)      ,/* 資料確認日 */
rtefstus       varchar2(10)      ,/* 狀態碼 */
rtefud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtefud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtefud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtefud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtefud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtefud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtefud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtefud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtefud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtefud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtefud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtefud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtefud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtefud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtefud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtefud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtefud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtefud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtefud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtefud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtefud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtefud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtefud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtefud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtefud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtefud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtefud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtefud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtefud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtefud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtef_t add constraint rtef_pk primary key (rtefent,rtefdocno) enable validate;

create unique index rtef_pk on rtef_t (rtefent,rtefdocno);

grant select on rtef_t to tiptop;
grant update on rtef_t to tiptop;
grant delete on rtef_t to tiptop;
grant insert on rtef_t to tiptop;

exit;
