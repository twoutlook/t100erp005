/* 
================================================================================
檔案代號:mraj_t
檔案名稱:資源保修項目明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table mraj_t
(
mrajent       number(5)      ,/* 企業編號 */
mrajsite       varchar2(10)      ,/* 營運據點 */
mraj001       varchar2(10)      ,/* 資源分類 */
mraj002       varchar2(20)      ,/* 資源編號 */
mraj003       varchar2(10)      ,/* 保修類型 */
mrajseq       number(10,0)      ,/* 項次 */
mraj004       varchar2(10)      ,/* 保修項目 */
mraj005       varchar2(10)      ,/* 保修部位 */
mraj006       varchar2(500)      ,/* 保修內容 */
mraj007       varchar2(20)      ,/* 儀表編號 */
mraj008       varchar2(80)      ,/* 儀錶記錄 */
mraj009       varchar2(80)      ,/* 儀錶標準值 */
mraj010       varchar2(1)      ,/* 更換零件否 */
mraj011       varchar2(1)      ,/* 零件內容 */
mraj012       number(15,3)      ,/* 預計時間 */
mraj013       varchar2(10)      ,/* 時間單位 */
mrajownid       varchar2(20)      ,/* 資料所有者 */
mrajowndp       varchar2(10)      ,/* 資料所屬部門 */
mrajcrtid       varchar2(20)      ,/* 資料建立者 */
mrajcrtdp       varchar2(10)      ,/* 資料建立部門 */
mrajcrtdt       timestamp(0)      ,/* 資料創建日 */
mrajmodid       varchar2(20)      ,/* 資料修改者 */
mrajmoddt       timestamp(0)      ,/* 最近修改日 */
mrajcnfid       varchar2(20)      ,/* 資料確認者 */
mrajcnfdt       timestamp(0)      ,/* 資料確認日 */
mrajstus       varchar2(10)      ,/* 狀態碼 */
mrajud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrajud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrajud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrajud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrajud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrajud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrajud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrajud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrajud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrajud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrajud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrajud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrajud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrajud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrajud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrajud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrajud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrajud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrajud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrajud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrajud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrajud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrajud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrajud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrajud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrajud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrajud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrajud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrajud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrajud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mraj_t add constraint mraj_pk primary key (mrajent,mrajsite,mraj001,mraj002,mraj003,mrajseq) enable validate;

create unique index mraj_pk on mraj_t (mrajent,mrajsite,mraj001,mraj002,mraj003,mrajseq);

grant select on mraj_t to tiptop;
grant update on mraj_t to tiptop;
grant delete on mraj_t to tiptop;
grant insert on mraj_t to tiptop;

exit;
