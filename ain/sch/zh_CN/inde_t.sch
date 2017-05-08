/* 
================================================================================
檔案代號:inde_t
檔案名稱:調撥差異調整單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table inde_t
(
indeent       number(5)      ,/* 企業編號 */
indesite       varchar2(10)      ,/* 營運據點 */
indeunit       varchar2(10)      ,/* 應用組織 */
indedocno       varchar2(20)      ,/* 單號 */
indedocdt       date      ,/* 單據日期 */
inde001       varchar2(20)      ,/* 來源調撥單號 */
inde002       varchar2(20)      ,/* 調整人員 */
inde003       varchar2(10)      ,/* 撥出營運據點 */
inde004       varchar2(10)      ,/* 撥入營運據點 */
inde005       varchar2(10)      ,/* 在途倉 */
inde101       varchar2(10)      ,/* 調整部門 */
inde102       varchar2(10)      ,/* 在途庫位(非成本庫) */
inde006       varchar2(255)      ,/* 備註 */
indeownid       varchar2(20)      ,/* 資料所有者 */
indeowndp       varchar2(10)      ,/* 資料所屬部門 */
indecrtid       varchar2(20)      ,/* 資料建立者 */
indecrtdp       varchar2(10)      ,/* 資料建立部門 */
indecrtdt       timestamp(0)      ,/* 資料創建日 */
indemodid       varchar2(20)      ,/* 資料修改者 */
indemoddt       timestamp(0)      ,/* 最近修改日 */
indecnfid       varchar2(20)      ,/* 資料確認者 */
indecnfdt       timestamp(0)      ,/* 資料確認日 */
indestus       varchar2(10)      ,/* 狀態碼 */
indeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
indeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
indeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
indeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
indeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
indeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
indeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
indeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
indeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
indeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
indeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
indeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
indeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
indeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
indeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
indeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
indeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
indeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
indeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
indeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
indeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
indeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
indeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
indeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
indeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
indeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
indeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
indeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
indeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
indeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inde_t add constraint inde_pk primary key (indeent,indedocno) enable validate;

create unique index inde_pk on inde_t (indeent,indedocno);

grant select on inde_t to tiptop;
grant update on inde_t to tiptop;
grant delete on inde_t to tiptop;
grant insert on inde_t to tiptop;

exit;
