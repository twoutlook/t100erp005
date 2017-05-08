/* 
================================================================================
檔案代號:mhbj_t
檔案名稱:圖紙資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table mhbj_t
(
mhbjent       number(5)      ,/* 企業編號 */
mhbjsite       varchar2(10)      ,/* 營運據點 */
mhbjunit       varchar2(10)      ,/* 應用組織 */
mhbj001       varchar2(10)      ,/* 樓棟編號 */
mhbj002       varchar2(10)      ,/* 樓層編號 */
mhbj003       varchar2(10)      ,/* 圖紙編號 */
mhbj005       number(5,0)      ,/* 版本 */
mhbj006       date      ,/* 生效日期 */
mhbj007       date      ,/* 失效日期 */
mhbjstus       varchar2(10)      ,/* 狀態碼 */
mhbjownid       varchar2(20)      ,/* 資料所有者 */
mhbjowndp       varchar2(10)      ,/* 資料所屬部門 */
mhbjcrtid       varchar2(20)      ,/* 資料建立者 */
mhbjcrtdp       varchar2(10)      ,/* 資料建立部門 */
mhbjcrtdt       timestamp(0)      ,/* 資料創建日 */
mhbjmodid       varchar2(20)      ,/* 資料修改者 */
mhbjmoddt       timestamp(0)      ,/* 最近修改日 */
mhbjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mhbjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mhbjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mhbjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mhbjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mhbjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mhbjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mhbjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mhbjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mhbjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mhbjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mhbjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mhbjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mhbjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mhbjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mhbjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mhbjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mhbjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mhbjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mhbjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mhbjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mhbjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mhbjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mhbjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mhbjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mhbjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mhbjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mhbjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mhbjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mhbjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mhbj_t add constraint mhbj_pk primary key (mhbjent,mhbjsite,mhbj003,mhbj005) enable validate;

create unique index mhbj_pk on mhbj_t (mhbjent,mhbjsite,mhbj003,mhbj005);

grant select on mhbj_t to tiptop;
grant update on mhbj_t to tiptop;
grant delete on mhbj_t to tiptop;
grant insert on mhbj_t to tiptop;

exit;
