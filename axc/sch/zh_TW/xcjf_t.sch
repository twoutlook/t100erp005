/* 
================================================================================
檔案代號:xcjf_t
檔案名稱:內部收入成本數據明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xcjf_t
(
xcjfent       number(5)      ,/* 企業編號 */
xcjfsite       varchar2(5)      ,/* 賬務中心 */
xcjfld       varchar2(5)      ,/* 帳套 */
xcjfdocno       varchar2(20)      ,/* 單據編號 */
xcjfseq       number(10,0)      ,/* 項次 */
xcjf001       varchar2(20)      ,/* 業務單據 */
xcjf002       number(10,0)      ,/* 項次 */
xcjf003       number(10,0)      ,/* 項次 */
xcjf010       varchar2(1)      ,/* 類型(收入/成本) */
xcjf011       varchar2(1)      ,/* 來源(存貨/在制) */
xcjf012       varchar2(1)      ,/* 計算類別(損益/資產) */
xcjf013       varchar2(10)      ,/* 實體利潤中心（組織) */
xcjf014       varchar2(10)      ,/* 虛擬利潤中心(組織) */
xcjf015       varchar2(10)      ,/* 交易組織(site) */
xcjf016       varchar2(40)      ,/* 料號 */
xcjf017       varchar2(30)      ,/* 倉庫 */
xcjf018       varchar2(30)      ,/* 批號 */
xcjf019       varchar2(10)      ,/* 異動類型 */
xcjf020       varchar2(10)      ,/* 基礎單位 */
xcjf021       number(5,0)      ,/* 出入庫碼 */
xcjf022       number(20,6)      ,/* 異動數量 */
xcjf023       varchar2(10)      ,/* 計價單位 */
xcjf024       number(20,6)      ,/* 換算率 */
xcjf028       varchar2(24)      ,/* 收入成本存貨科目 */
xcjf029       varchar2(24)      ,/* 對方科目 */
xcjf030       varchar2(80)      ,/* 摘要 */
xcjf031       varchar2(10)      ,/* 部門 */
xcjf032       varchar2(10)      ,/* 成本中心 */
xcjf033       varchar2(10)      ,/* 區域 */
xcjf034       varchar2(10)      ,/* 交易對象 */
xcjf035       varchar2(10)      ,/* 帳款對象 */
xcjf036       varchar2(10)      ,/* 客群 */
xcjf037       varchar2(10)      ,/* 品類 */
xcjf038       varchar2(10)      ,/* 經營類別 */
xcjf039       varchar2(10)      ,/* 渠道 */
xcjf040       varchar2(10)      ,/* 品牌 */
xcjf041       varchar2(20)      ,/* 人員 */
xcjf042       varchar2(20)      ,/* 項目號 */
xcjf043       varchar2(30)      ,/* WBS */
xcjf044       varchar2(10)      ,/* 自由核算項1 */
xcjf045       varchar2(10)      ,/* 自由核算項2 */
xcjf046       varchar2(10)      ,/* 自由核算項3 */
xcjf047       varchar2(10)      ,/* 自由核算項4 */
xcjf048       varchar2(10)      ,/* 自由核算項5 */
xcjf049       varchar2(10)      ,/* 自由核算項6 */
xcjf050       varchar2(10)      ,/* 自由核算項7 */
xcjf051       varchar2(10)      ,/* 自由核算項8 */
xcjf052       varchar2(10)      ,/* 自由核算項9 */
xcjf053       varchar2(10)      ,/* 自由核算項10 */
xcjf101       varchar2(10)      ,/* 交易幣別 */
xcjf102       number(20,6)      ,/* 交易單價 */
xcjf110       number(20,6)      ,/* 交易金額 */
xcjf200       number(20,10)      ,/* 換算匯率 */
xcjf201       number(20,6)      ,/* 本位幣一金額 */
xcjf210       number(20,10)      ,/* 換算匯率二 */
xcjf211       number(20,6)      ,/* 本位幣二金額 */
xcjf220       number(20,10)      ,/* 換算匯率三 */
xcjf221       number(20,6)      ,/* 本位幣三金額 */
xcjfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcjfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcjfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcjfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcjfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcjfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcjfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcjfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcjfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcjfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcjfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcjfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcjfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcjfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcjfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcjfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcjfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcjfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcjfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcjfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcjfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcjfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcjfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcjfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcjfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcjfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcjfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcjfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcjfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcjfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcjf_t add constraint xcjf_pk primary key (xcjfent,xcjfld,xcjfdocno,xcjfseq) enable validate;

create unique index xcjf_pk on xcjf_t (xcjfent,xcjfld,xcjfdocno,xcjfseq);

grant select on xcjf_t to tiptop;
grant update on xcjf_t to tiptop;
grant delete on xcjf_t to tiptop;
grant insert on xcjf_t to tiptop;

exit;
